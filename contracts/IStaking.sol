// SPDX-License-Identifier: AGPL-3.0-only

/**
 *   IStaking.sol - fair-manager
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

import {ICommittee} from "./ICommittee.sol";
import {INodes, NodeId} from "./INodes.sol";
import {IRewardWallet} from "./IRewardWallet.sol";
import {Fair, Timestamp} from "./units.sol";

interface IStaking {

    struct ExitRequest {
        uint256 requestId;
        address user;
        NodeId nodeId;
        Fair amount;
        Timestamp unlockDate;
    }

    // =============================================================
    //                           RECEIVE
    // =============================================================

    receive() external payable;

    // =============================================================
    //                       WRITE FUNCTIONS
    // =============================================================

    function initialize(
        address initialAuthority,
        ICommittee committee,
        INodes nodes,
        IRewardWallet rewardWalletReference
    ) external;

    function addAllowedReceiver(address receiver) external;
    function claimRequest(uint256 requestId) external;
    function disable(NodeId node) external;
    function enable(NodeId node) external;
    function nodeRemoved(NodeId node) external;
    function payReward(NodeId node) external payable;
    function nodeCreated(NodeId node, address nodeAddress) external payable;
    function removeAllowedReceiver(address receiver) external;
    function requestAllFees(NodeId node) external;
    function requestFees(NodeId node, Fair amount) external;
    function requestRetrieve(NodeId node, Fair value) external;
    function requestRetrieveAll(NodeId node) external;
    function requestSendAllFees(address payable to) external;
    function requestSendFees(address payable to, Fair amount) external;
    function setFeeRate(uint16 feeRate) external;
    function setSelfStakeRequirement(Fair amount) external;
    function setRetrievingDelay(Timestamp delay) external;
    function setRewardWalletReference(IRewardWallet rewardWalletReference_) external;
    function setStakeLimit(Fair limit) external;
    function stake(NodeId node) external payable;

    // =============================================================
    //                       READ FUNCTIONS
    // =============================================================

    function getDelegatorsToNode(NodeId node) external view returns (address[] memory delegators);
    function getDelegatorsToNodeCount(NodeId node) external view returns (uint256 count);
    function getEarnedFeeAmount(NodeId node) external view returns (Fair amount);
    function getExitRequest(uint256 requestId) external view returns (ExitRequest memory request);
    function getExitRequestAt(address user, uint256 index) external view returns (ExitRequest memory request);
    function getExitRequestsCountFor(address user) external view returns (uint256 count);
    function getMyExitRequestsCount() external view returns (uint256 count);
    function getMyTotalInExitQueue() external view returns (Fair amount);
    function getNodeFeeRate(NodeId node) external view returns (uint16 feeRate);
    function getNodeShare(NodeId node) external view returns (uint256 share);
    function getNodeTotalStake(NodeId node) external view returns (Fair amount);
    function getRetrievingDelay() external view returns (Timestamp delay);
    function getRewardWallet(NodeId node) external view returns (IRewardWallet rewardWallet);
    function getStakedAmount() external view returns (Fair amount);
    function getStakedAmountFor(address holder) external view returns (Fair amount);
    function getStakedNodes() external view returns (NodeId[] memory stakedNodes);
    function getStakedNodesFor(address holder) external view returns (NodeId[] memory stakedNodes);
    function getStakedToNodeAmount(NodeId node) external view returns (Fair amount);
    function getStakedToNodeAmountFor(NodeId node, address holder) external view returns (Fair amount);
    function getTotalInExitQueueFor(address user) external view returns (Fair amount);
    function getTotalInExitQueue() external view returns (Fair amount);
    function getUnlockedExitRequestFor(
        address user,
        uint256 fromIndex
    ) external view returns (ExitRequest memory request);
    function isNodeEnabled(NodeId node) external view returns (bool enabled);
    function isRequestUnlocked(uint256 requestId) external view returns (bool unlocked);
    function isWithinStakeLimit(NodeId node) external view returns (bool result);
    function stakeLimit() external view returns (Fair amount);
}
