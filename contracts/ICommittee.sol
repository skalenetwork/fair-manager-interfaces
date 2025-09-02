// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   ICommittee.sol - fair-manager
 *   Copyright (C) 2025-Present SKALE Labs
 *   @author Dmytro Stebaiev
 *
 *   fair-manager is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU Affero General Public License as published
 *   by the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   fair-manager is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU Affero General Public License for more details.
 *
 *   You should have received a copy of the GNU Affero General Public License
 *   along with fair-manager.  If not, see <https://www.gnu.org/licenses/>.
 */

pragma solidity ^0.8.24;

import {DkgId, IDkg} from "./IDkg.sol";
import {INodes, NodeId} from "./INodes.sol";
import {IStaking} from "./IStaking.sol";
import {Duration, IStatus} from "./IStatus.sol";
import {Timestamp} from "./units.sol";

type CommitteeIndex is uint256;


interface ICommittee {
    struct Committee {
        NodeId[] nodes;
        DkgId dkg;
        IDkg.G2Point commonPublicKey;
        Timestamp startingTimestamp;
    }

    event VersionUpdated(string version, string newVersion);

    function initialize(
        address initialAuthority,
        INodes nodesAddress,
        IDkg.G2Point memory commonPublicKey,
        NodeId[] memory nodeIds
    ) external;
    function ejectUnhealthyNode() external;
    function nodeBlacklisted(NodeId node) external;
    function nodeRemoved(NodeId node) external;
    function nodeWhitelisted(NodeId node) external;
    function processHeartbeat(NodeId node) external;
    function processSuccessfulDkg(DkgId dkg) external;
    function select() external;
    function setCommitteeSize(uint256 size) external;
    function setRNG(address newRNG) external;
    function disableRNG() external;
    function setStaking(IStaking stakingAddress) external;
    function setDkg(IDkg dkgAddress) external;
    function setMinTransitionDelay(Duration delay) external;
    function setNodes(INodes nodesAddress) external;
    function setStatus(IStatus statusAddress) external;
    function setTransitionDelay(Duration delay) external;
    function setVersion(string calldata newVersion) external;
    function updateWeight(NodeId node, uint256 share) external;
    function status() external view returns(IStatus statusContract);
    function isNodeInCurrentOrNextCommittee(NodeId node) external view returns (bool result);
    function getActiveCommitteeIndex() external view returns (CommitteeIndex committeeIndex);
    function getCommittee(CommitteeIndex committeeIndex) external view returns (Committee memory committee);
    function staking() external view returns (IStaking stakingAddress);
}
